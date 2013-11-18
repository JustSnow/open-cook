require "#{Rails.root}/lib/tasks/includes/connect_ae_db"
require "#{Rails.root}/lib/tasks/includes/ae2oc_db"

# helpers
def create_system_hub slug, title, type
  User.root.hubs.where(title: title).first_or_create!(
    slug:  slug,
    title: title,
    pubs_type: type,
    state: :published
  )
end

def create_hub_category category
  user_root = User.root

  hub_category = Hub.nested_set.new(
    title: category.title,
    # main_image_file_name: category.big_image_file_name,
    # main_image_content_type: category.big_image_content_type,
    # main_image_file_size: category.big_image_file_size,
    slug: category.slug,
    keywords: category.meta_keywords,
    description: category.meta_description.to_s[0..250],
    state: :published,
    user: user_root
  )
  hub_category
end

def find_parent_category category
  ae_category = AE_Category.where('id = ?', category.category_id).first
  hub_category = Hub.where('slug = ?', ae_category.slug)
  hub_category
end

# rake ae:user_start
namespace :ae do
  desc "Clean up DB"
  task clean_db: :environment do
    Role.destroy_all
    User.destroy_all

    Hub.delete_all
  end

  desc "Create Role"
  task create_roles: [:environment, :clean_db] do
    admin_role = Role.create!(
      name: :admin,
      title: "Admin Role",
      description: "Admin can do anything"
    )

    blogger = Role.create!(
      name: :blogger,
      title: "Blogger role",
      description: "Blogger can manage his Comments and post in Blog hub"
    )

    author = Role.create!(
      name: :author,
      title: "Author role",
      description: "Blogger can manage his Comments and Post in Few Hubs (Articles, Blogs, Recipes, Videos)"
    )

    #######################################################
    # Update Role's Abilities
    #######################################################

    admin_role.create_rule(:system, :administrator)
    admin_role.rule_on(:system, :administrator)

    blogger.update_role(
      users: {
        cabinet: true
      },
      posts: {
        new:     true,
        create:  true,
        edit:    true,
        update:  true,
        rebuild: true,
        destroy: true
      },
      available_hubs: {
        blogs: true
      }
    )

    author.update_role(
      users: {
        cabinet: true
      },
      posts: {
        new:     true,
        create:  true,
        edit:    true,
        update:  true,
        rebuild: true,
        destroy: true
      },
      available_hubs: {
        blogs:    true,
        videos:   true,
        recipes:  true,
        articles: true,
        interviews: true
      }
    )

    puts "Roles created"
  end

  desc "Перетягиваем пользователей"
  task user_start: [:environment, :create_roles] do
    puts "User start =>"
    # ae_users = AE_User.all
    ae_users = AE_User.limit(2)
    user_count = ae_users.count

    # create admin
    puts "Create admin"
    admin = User.new(
      login: 'admin',
      username: 'admin',
      email: 'admin@example.com',
      password: 'admin',
      role_id: 1
    )

    if admin.save
      puts "Admin успешно создан"
    else
      puts "#{admin.errors.to_a.to_s.red}"
    end

    ae_users.each_with_index do |aeuser, index|
      user = User.new(
        login: aeuser.email,
        username: aeuser.nick,
        email: aeuser.email,
        role_id: 2,
        created_at: aeuser.created_at,
        updated_at: aeuser.updated_at,
        password: 'password'
      )

      if user.save
        puts "#{aeuser.nick} => #{index+1}/#{user_count}"
      else
        puts "#{aeuser.nick} - #{user.errors.to_a.to_s.red} => #{index+1}/#{user_count}"
      end
    end
  end

  desc "Создаем основной hub для категорий статей"
  task create_root_category_hub: [:environment, :user_start] do
    puts "Создаем основной hub для категорий статей"
    create_system_hub(:system_article_categories, "КатегорииСтатей", :categories)
  end

  desc "Перетаскиваем категории в основной hub для категорий статей"
  task categories_start: [:environment, :create_root_category_hub] do
    ae_categories = AE_Category.all
    ae_categories_count = ae_categories.count

    root_hub_categories = Hub.where(title: "КатегорииСтатей").first

    ae_categories.each_with_index do |ae_category, index|
      hub_category = create_hub_category ae_category

      if hub_category.save
        hub_category.move_to_child_of root_hub_categories
        puts "#{ae_category.slug} => #{index+1}/#{ae_categories_count}"
      else
        puts "#{ae_category.slug} - #{hub_category.errors.to_a.to_s.red} => #{index+1}/#{ae_categories_count}"
      end
    end

    # перетягиваем подкатегории
    ae_subcategories = AE_Subcategory.all
    ae_subcategories_count = ae_subcategories.count

    puts "Перетягиваем подкатегории"
    ae_subcategories.each_with_index do |ae_subcategory, index|
      hub_subcategory = create_hub_category ae_subcategory

      if hub_subcategory.save
        hub_subcategory.move_to_child_of find_parent_category(ae_subcategory)
        puts "#{ae_subcategory.slug} => #{index+1}/#{ae_subcategories_count}"
      else
        puts "#{ae_subcategory.slug} - #{hub_subcategory.errors.to_a.to_s.red} => #{index+1}/#{ae_subcategories_count}"
      end
    end
  end

  desc "Перетягиваем теги из AE в Open-cook"
  task tags_start: :environment do
    
  end
end
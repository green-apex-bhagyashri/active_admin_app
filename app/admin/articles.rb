ActiveAdmin.register Article, as: 'Blog' do
  # menu false //It will  Disable the tab
  # menu label: "My Posts" // It will change the tab name blog to My Posts
  # menu label: proc{ I18n.t "mypost" }  using translation
  

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :published_at, :author_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :published_at, :author_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  config.batch_actions = false


  action_item :publish, only: :show do
    link_to "publish", publish_admin_blog_path(article), method: :put #if !article.published_at
  end

  form title: "Articles" do |f|
    f.inputs 'Article' do
      f.input :author
      f.input :title
      f.input :published_at, as: :date_time_picker
      f.input :description, as: :quill_editor
     end
     f.actions
  end

  # show do
  #   # byebug
  #   h3 article.description
    
  # end

  index do
    selectable_column
    # column :article
    column 'Title' do |article|
      link_to article.title, admin_blog_path(article)
    end
    column 'description' do |article|
      raw article.description.truncate_words(10)
    end
    column 'published_at' do |article|
      article.published_at
    end
    actions
  end

  filter :title
  filter :published_at

  member_action :publish, method: :put do
    article = Article.find(params[:id])
    article.update(published_at: Time.zone.now)
    redirect_to admin_article_path(article)
  end

  # show title: "Your Article" do
  #   h1 link_to article.title, admin_articles_path
  #   h4 link_to article.author.name, admin_article_path(article.author.id)
  #   div(class: 'article-body') do
  #raw article.description
  #   end
  # end

  show title: 'Blog Show' do
    attributes_table do
      row :title do |object|
        raw(object.title)
      end
      row :Description do |object|
        raw(object.description)
      end
      row :created_at
      row :updated_at
    end
  end
  
end

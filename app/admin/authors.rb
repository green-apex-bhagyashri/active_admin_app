ActiveAdmin.register Author do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, article_ids: []
  config.batch_actions = false

  show title: 'My title' do
    div(class: 'head') do
      h1 'You have ' + pluralize(author.articles.count, 'article') + ' for this author'
    end

    author.articles.each do |article|
      div do
        h2 article.title
        h3 link_to "[#{article.id}]: you created this article on #{article.created_at.strftime('%d %m, %Y')}", admin_blog_path(article)
      end
    end
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

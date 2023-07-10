# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel 'General Information' do
          para "welcome to the Articles application"
        end
      end
    end

    columns do
      column do
        panel 'Recent Articles' do
          ul do
            Article.order(created_at: :desc).first(5).map do |article|
              li link_to(article.title, admin_blog_path(article))
            end
          end
        end
      end
      column do
        panel 'Authors' do
          ul do
            Author.order(created_at: :asc).first(5).map do |author|
              li link_to(author.name, admin_author_path(author))
            end
          end
        end
      end
    end
  end # content
end

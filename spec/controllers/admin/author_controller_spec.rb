require "rails_helper"
# require "redis_helper"
RSpec.describe Admin::AuthorsController, type: :controller do
	let!(:admin_user) { FactoryBot.create(:admin_user)}

	let!(:author) { FactoryBot.create(:author)}
  # let!(:article) {FactoryBot.create(:article, title: "test", description: "tkjfhjhikj jffg", published_at: Time.current + 5.minutes, author_id: author.id)}

	render_views

	describe "List of Authors" do
    	context Constant::WHEN_ADMIN_NOT_LOGIN do
      		it Constant::REDIRECT_LOGIN do
        	get :index
        	expect(response).to redirect_to(new_admin_user_session_path)
      	end
    end

    context Constant::WHEN_ADMIN_LOGIN do
      before { sign_in(admin_user) }
      	it Constant::STATUS_OK do
        	get :index
        	expect(response.status).to eq(200)
      	end
    end
  end

  describe "Create Author" do
	    context Constant::WHEN_ADMIN_LOGIN do
	      before { sign_in(admin_user) }
	      it Constant::STATUS_OK do
	        post :create, params: {name: "amin shah"}
	        expect(response.status).to eq(302)
	      end
	    end

		context Constant::WHEN_ADMIN_NOT_LOGIN do
		  it Constant::REDIRECT_LOGIN do
		    post :create
		    expect(response).to redirect_to(new_admin_user_session_path)
		  end
		end
  end

  describe "show Author" do
    let!(:article) {FactoryBot.create(:article, title: "test", description: "tkjfhjhikj jffg", published_at: Time.current + 5.minutes, author_id: author.id)}
      context Constant::WHEN_ADMIN_NOT_LOGIN do
        it Constant::REDIRECT_LOGIN do
          get :show, params: {id: author.id}
          expect(response).to redirect_to(new_admin_user_session_path)
        end
      end

    context Constant::WHEN_ADMIN_LOGIN do
      before { sign_in(admin_user) }
      it Constant::STATUS_OK do
        get :show, params: {id: author.id}
        expect(response.status).to eq(200)
      end
      it "when author article present" do
        expect(author.articles).to include(article)
      end
    end
  end

	describe "Update Author" do
    	context Constant::WHEN_ADMIN_LOGIN do
      	before { sign_in(admin_user) }
      	it Constant::STATUS_302 do
        		patch :update, params: {id: author.id, name: "test"}
        		expect(response.status).to eq(302)
      	end
    	end

    	context Constant::WHEN_ADMIN_NOT_LOGIN do
      	it Constant::REDIRECT_LOGIN do
        		patch :update, params: {id: author.id, name: "test"}
        		expect(response).to redirect_to(new_admin_user_session_path)
      	end
    	end
  end

  describe "Destroy Question Type" do
    	context Constant::WHEN_ADMIN_NOT_LOGIN do
        	it Constant::REDIRECT_LOGIN do
          	delete :destroy, params: {id: author.id}
          	expect(response).to redirect_to(new_admin_user_session_path)
        	end
    	end

  	context Constant::WHEN_ADMIN_LOGIN do
      	before { sign_in(admin_user) }
      	it Constant::STATUS_302 do
        		delete :destroy, params: {id: author.id}
        		expect(response.status).to eq(302)
      	end
  	end
	end
end
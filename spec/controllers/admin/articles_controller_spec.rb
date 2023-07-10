require "rails_helper"
# require "redis_helper"
RSpec.describe Admin::BlogsController, type: :controller do
	let!(:admin_user) { FactoryBot.create(:admin_user)}
	#  before(:each) do
	 let!(:author) { FactoryBot.create(:author)}
	#  end
	let!(:article) { FactoryBot.create(:article)}

	render_views

	describe "List of Blogs" do
    	context "when admin not logged in" do
      		it "redirect to login" do
        	get :index
        	expect(response).to redirect_to(new_admin_user_session_path)
      	end
    end

    context "when admin logged in" do
      before { sign_in(admin_user) }
      	it "should have status 200" do
        	get :index
        	expect(response.status).to eq(200)
      	end
    end
  end

  describe "Create Blog" do
  	# let!(:author) { FactoryBot.create(:author)}
	    context "when admin logged in" do
	      before { sign_in(admin_user) }
	      it "should have status 200" do
	        post :create, params: {title: "Descriptive", description: "this is my first blog", author_id: author.id}
	        expect(response.status).to eq(200)
	      end
	    end

		context "when admin not logged in" do
		  it "redirect to login" do
		    post :create
		    expect(response).to redirect_to(new_admin_user_session_path)
		  end
		end
  end

  describe "show Blog" do
      context "when admin not logged in" do
        it "redirect to login" do
          get :show, params: {id: article.id}
          expect(response).to redirect_to(new_admin_user_session_path)
        end
      end

    context "when admin logged in" do
      before { sign_in(admin_user) }
      it "should have status 200" do
        get :show, params: {id: article.id}
        expect(response.status).to eq(200)
      end
    end
  end

  describe "Update Blog" do
      context "when admin logged in" do
        before { sign_in(admin_user) }
        it "has a 302 status code" do
          patch :update, params: {id: article.id, title: "title", description: "this is my first blog",author_id: author.id}
          expect(response.status).to eq(302)
        end
      end

      context "when admin not logged in" do
        it "redirect to login" do
          patch :update, params: {id: article.id, title: "title", description: "this is my first blog",author_id: author.id}
          expect(response).to redirect_to(new_admin_user_session_path)
        end
      end
    end

    describe "Destroy Question Type" do
      context "when admin not logged in" do
          it "redirect to login" do
            delete :destroy, params: {id: article.id}
            expect(response).to redirect_to(new_admin_user_session_path)
          end
      end

    context "when admin logged in" do
        before { sign_in(admin_user) }
        it "has a 302 status code" do
          delete :destroy, params: {id: article.id}
          expect(response.status).to eq(302)
        end
    end
  end
end
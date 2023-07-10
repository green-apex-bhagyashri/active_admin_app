require "rails_helper"
# require "redis_helper"
RSpec.describe Admin::AdminUsersController, type: :controller do
	let!(:admin_user) { FactoryBot.create(:admin_user)}

	render_views

	describe "List admin users" do
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

  describe "show Admin user" do
      context Constant::WHEN_ADMIN_NOT_LOGIN do
        it Constant::REDIRECT_LOGIN do
          get :show, params: {id: admin_user.id}
          expect(response).to redirect_to(new_admin_user_session_path)
        end
      end

    context Constant::WHEN_ADMIN_LOGIN do
      before { sign_in(admin_user) }
      it Constant::STATUS_OK do
        get :show, params: {id: admin_user.id}
        expect(response.status).to eq(200)
      end
    end
  end

  describe "Create Admin User" do
      context Constant::WHEN_ADMIN_LOGIN do
        before { sign_in(admin_user) }
        it Constant::STATUS_OK do
          post :create, params: {email: "admin@text.com", password: "password", password_confirmation: "password"}
          expect(response.status).to eq(200)
        end
      end

    context Constant::WHEN_ADMIN_NOT_LOGIN do
      it Constant::REDIRECT_LOGIN do
        post :create
        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end
    end

    describe "Update Question Type" do
      context Constant::WHEN_ADMIN_LOGIN do
        before { sign_in(admin_user) }
        it "has a 302 status code" do
          patch :update, params: {id: admin_user.id, admin_user: "MCQ"}
          expect(response.status).to eq(302)
        end
      end

      context Constant::WHEN_ADMIN_NOT_LOGIN do
        it Constant::REDIRECT_LOGIN do
          patch :update, params: {id: admin_user.id, description: "Selectable"}
          expect(response).to redirect_to(new_admin_user_session_path)
        end
      end
    end

    describe "Destroy Question Type" do
      context Constant::WHEN_ADMIN_NOT_LOGIN do
          it Constant::REDIRECT_LOGIN do
            delete :destroy, params: {id: admin_user.id}
            expect(response).to redirect_to(new_admin_user_session_path)
          end
      end

    context Constant::WHEN_ADMIN_LOGIN do
        before { sign_in(admin_user) }
        it "has a 302 status code" do
          delete :destroy, params: {id: admin_user.id}
          expect(response.status).to eq(302)
        end
    end
  end
end
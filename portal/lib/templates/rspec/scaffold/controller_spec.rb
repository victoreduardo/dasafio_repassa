# frozen_string_literal: true

require "rails_helper"

RSpec.describe <%= class_name.pluralize %>Controller, type: :controller do
  let(:correct_breadcrumbs) { ["<%= class_name.split('::').first.downcase %>", controller.pluralize_model(<%= class_name %>)] }

  describe "GET #index" do
    let(:<%= plural_name %>) { create_list(:<%= singular_name %>, 2) }

    before { get :index }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza index view" do
      expect(response).to render_template :index
    end

    it "popula uma variável <%= plural_name %>" do
      expect(assigns(:<%= controller_name.gsub('::','').underscore %>)).to eq(<%= plural_name %>)
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(correct_breadcrumbs)
    end
  end

  describe "GET #show" do
    let(:show_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:show) }

    let(:<%= singular_name %>) { create(:<%= singular_name %>) }

    before { get :show, params: { id: <%= singular_name %>.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza show view" do
      expect(response).to render_template :show
    end

    it "popula uma variável @<%= singular_name %>" do
      expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to eq(<%= singular_name %>)
    end

    it "instancia uma variável de <%= class_name %>" do
      expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a(<%= class_name %>)
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(show_breadcrumbs)
    end
  end

  describe "GET #new" do
    let(:new_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:new) }

    before { get :new }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza new view" do
      expect(response).to render_template :new
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(new_breadcrumbs)
    end

    it "instancia uma nova variável @<%= singular_name %> com <%= class_name %>" do
      expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a_new(<%= class_name %>)
    end
  end

  describe "GET #edit" do
    let(:edit_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:edit) }

    let(:<%= singular_name %>) { create(:<%= singular_name %>) }

    before { get :edit, params: { id: <%= singular_name %>.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza edit view" do
      expect(response).to render_template :edit
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(edit_breadcrumbs)
    end

    it "instancia uma variável @<%= singular_name %> com um objeto de <%= class_name %>" do
      expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to eq(<%= singular_name %>)
    end

    it "instancia uma variável de <%= class_name %>" do
      expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a(<%= class_name %>)
    end
  end

  describe "POST #create" do
    before { post :create, params: { <%= class_name.gsub('::','').underscore %>: <%= plural_name %>_attributes } }

    context "com parametros válidos" do
      let(:<%= plural_name %>_attributes) { attributes_for(:<%= singular_name %>) }

      it "verifica a persistencia da variável @<%= singular_name %>" do
        expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_persisted
      end

      it "instancia uma variável de <%= class_name %>" do
        expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a(<%= class_name %>)
      end

      it "salva o <%= singular_name %> correto" do
        expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to eq(<%= class_name %>.last)
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    context "com parametros inválidos" do
      # let(:<%= plural_name %>_attributes) { attributes_for(:<%= singular_name %>, atributo_not_null: nil) }
      #
      # it "instancia uma variável de <%= class_name %>" do
      #   expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a(<%= class_name %>)
      # end
      #
      # it "não cria um novo <%= class_name %>" do
      #   expect(assigns(:<%= class_name.gsub('::','').underscore %>)).not_to be_persisted
      # end
      #
      # it "renderiza a view #new" do
      #   expect(response).to render_template :new
      # end
    end
  end

  describe "PUT #update" do
    before { put :update, params: { id: <%= singular_name %>.id, <%= class_name.gsub('::','').underscore %>: <%= plural_name %>_attributes } }

    context "com parametros válidos" do
      let(:<%= singular_name %>) { create(:<%= singular_name %>) }
      let(:<%= plural_name %>_attributes) { attributes_for(:<%= singular_name %>)} #, atributo: "Foo Bar") }

      it "instancia uma variável de <%= class_name %>" do
        expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a(<%= class_name %>)
      end

      it "salva as alterações corretamente" do
        #<%= singular_name %>.reload
        #expect(<%= singular_name %>.atributo).to eq("Foo Bar")
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    context "com parametros inválidos" do
      # let(:<%= singular_name %>) { create(:<%= singular_name %>) }
      # let(:<%= plural_name %>_attributes) { attributes_for(:<%= singular_name %>, atributo_not_null: nil) }
      #
      # it "instancia uma variável de <%= class_name %>" do
      #   expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a(<%= class_name %>)
      # end
      #
      # it "não salva as alterações" do
      #   <%= singular_name %>.reload
      #   expect(<%= singular_name %>.atributo_not_null).not_to eq(nil)
      # end
      #
      # it "renderiza a view #edit" do
      #   expect(response).to render_template(:edit)
      # end
    end
  end

  describe "DELETE #destroy" do
    let(:<%= singular_name %>) { create(:<%= singular_name %>) }

    before { delete :destroy, params: { id: <%= singular_name %>.id } }

    it "instancia uma variável de <%= class_name %>" do
      expect(assigns(:<%= class_name.gsub('::','').underscore %>)).to be_a(<%= class_name %>)
    end

    it "remove o <%= singular_name %>" do
      expect(<%= class_name %>.count).to eq(0)
    end

    it "redireciona para #index" do
      expect(response).to redirect_to(<%= controller_name.gsub('::','').underscore %>_path)
    end
  end
end

if defined?(Ckeditor::AttachmentFilesController)
  Ckeditor::AttachmentFilesController.class_eval do
    load_and_authorize_resource class: 'Ckeditor::AttachmentFile'
    after_action :set_supplier, only: [:create]

    def index; end

    private

    def set_supplier
      if try_spree_current_user.supplier? && @attachment
        @attachment.supplier = try_spree_current_user.supplier
        @attachment.save
      end
    end
  end
end

class AddPermalinkToSuppliers < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_suppliers, :slug, :string
    add_index :spree_suppliers, :slug, unique: true
  end
end

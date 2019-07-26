require 'spec_helper'

module Spree
  module Stock
    module Splitter
      describe DropShip do

        let(:supplier_1) { create(:supplier) }
        let(:supplier_2) { create(:supplier) }

        let(:variant_1) {
          v = create(:variant)
          v.product.add_supplier! supplier_1
          v.reload.supplier_variants.find_by_supplier_id(supplier_1.id).update_column(:cost, 5)
          v.product.add_supplier! supplier_2
          v.reload.supplier_variants.find_by_supplier_id(supplier_2.id).update_column(:cost, 6)
          v
        }
        let(:variant_2) {
          v = create(:variant)
          v.product.add_supplier! supplier_1
          v.reload.supplier_variants.find_by_supplier_id(supplier_1.id).update_column(:cost, 5)
          v.product.add_supplier! supplier_2
          v.reload.supplier_variants.find_by_supplier_id(supplier_2.id).update_column(:cost, 4)
          v
        }
        let(:variant_3) {
          v = create(:variant)
          v.product.add_supplier! supplier_1
          v.product.add_supplier! supplier_2
          v.reload
        }
        let(:variant_4) { create(:variant) }

        let(:variants){
          [variant_1, variant_2, variant_3, variant_4]
        }

        let(:packer) { build(:stock_packer) }

        subject { DropShip.new(packer) }

        it 'splits packages for drop ship' do
          package = Package.new(packer.stock_location)
          package = Package.new(packer.stock_location)
          4.times { |i| package.add build(:inventory_unit, variant: variants[i]) }

          packages = subject.split([package])
          packages.count.should eq 3

          expect(packages[0].stock_location).to eq(packer.stock_location)
          expect(packages[0].contents.count).to eq(1)
          expect(packages[1].stock_location).to eq(supplier_1.stock_locations.first)
          expect(packages[1].contents.count).to eq(2)
          expect(packages[2].stock_location).to eq(supplier_2.stock_locations.first)
          expect(packages[2].contents.count).to eq(1)
        end

      end
    end
  end
end

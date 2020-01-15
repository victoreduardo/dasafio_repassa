class CreateTbCargos < ActiveRecord::Migration[5.2]
  def change
    unless table_exists? :tb_cargos
      create_table :tb_cargos do |t|
        t.string :nome
        t.decimal :salario
        t.string :chave, index: true

        t.timestamps
      end
    end
  end
end

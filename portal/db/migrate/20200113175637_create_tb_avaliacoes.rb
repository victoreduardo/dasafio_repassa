class CreateTbAvaliacoes < ActiveRecord::Migration[5.2]
  def change
    create_table :tb_avaliacoes do |t|
      t.integer :tb_empregado_id
      t.integer :tb_empregado_gerente_id
      t.decimal :media
      t.datetime :dta_finalizacao
      t.integer :status, default: 1, null: false, index: true

      t.timestamps
    end
    add_foreign_key TbAvaliacao.table_name,
                    TbEmpregado.table_name,
                    column: :tb_empregado_id
    add_foreign_key TbAvaliacao.table_name,
                    TbEmpregado.table_name,
                    column: :tb_empregado_gerente_id
  end
end

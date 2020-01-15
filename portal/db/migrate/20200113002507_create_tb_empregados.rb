class CreateTbEmpregados < ActiveRecord::Migration[5.2]
  def change
    unless table_exists? :tb_empregados
      create_table :tb_empregados do |t|
        t.string :nome
        t.string :nmr_cpf
        t.string :end_email
        t.date :dta_nascimento
        t.integer :sexo
        t.date :dta_admissao
        t.integer :tb_cargo_id

        t.timestamps
      end
      add_foreign_key TbEmpregado.table_name,
                      TbCargo.table_name,
                      column: :tb_cargo_id
    end
  end
end

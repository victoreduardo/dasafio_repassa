class CriaColunaUserTbEmpregadoId < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? User.table_name, :tb_empregado_id
      add_column User.table_name, :tb_empregado_id, :integer, comment: 'FK TbEmpregado table'
      add_foreign_key User.table_name,
                      TbEmpregado.table_name,
                      column: :tb_empregado_id
    end
  end
end

class CreateTbRespostas < ActiveRecord::Migration[5.2]
  def change
    create_table :tb_respostas do |t|
      t.integer :tb_avaliacao_id
      t.integer :tb_pergunta_id
      t.integer :nota
      t.text :obs

      t.timestamps
    end
    add_foreign_key TbResposta.table_name,
                    TbAvaliacao.table_name,
                    column: :tb_avaliacao_id
    add_foreign_key TbResposta.table_name,
                    TbPergunta.table_name,
                    column: :tb_pergunta_id
  end
end

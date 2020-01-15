class CreateTbPerguntas < ActiveRecord::Migration[5.2]
  def change
    create_table :tb_perguntas do |t|
      t.string :nme_pergunta
      t.string :descricao
      t.integer :peso

      t.timestamps
    end
  end
end

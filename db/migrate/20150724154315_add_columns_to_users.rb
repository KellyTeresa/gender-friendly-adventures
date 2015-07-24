class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pronoun_subject, :string, default: "they"
    add_column :users, :pronoun_object, :string, default: "them"
    add_column :users, :pronoun_adjective, :string, default: "their"
    add_column :users, :pronoun_possessive, :string, default: "theirs"
    add_column :users, :pronoun_reflexive, :string, default: "themself"
    add_column :users, :gender, :string
  end
end

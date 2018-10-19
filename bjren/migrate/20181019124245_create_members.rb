# http://sequel.jeremyevans.net/rdoc/files/doc/schema_modification_rdoc.html
Sequel.migration do
  up do
    # extension :pg_enum
    create_table(:members) do
      primary_key :id
      String :name, null: false
      String :unit
      Float :score
      String :id_card
      String :id_card_sha
      String :id_num
      String :unit_group
      Date   :birthday
      Integer :gender

      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP #, :index=>true
      DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:members)
  end
end

# http://sequel.jeremyevans.net/rdoc/files/doc/schema_modification_rdoc.html
Sequel.migration do
  up do
    # extension :pg_enum
    create_table(:members) do
      primary_key :id
      String  :name, null: false, size: 10
      String  :unit, size: 100
      Float   :score
      Date    :birthday
      String  :gender, size: 10
      String  :id_num, fixed: true, size: 18
      String  :id_card, fixed: true, size: 18
      String  :id_card_sha, fixed: true, size: 64, unique: true

      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP #, :index=>true
      DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:members)
  end
end

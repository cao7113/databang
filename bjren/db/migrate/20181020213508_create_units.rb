# http://sequel.jeremyevans.net/rdoc/files/doc/schema_modification_rdoc.html
Sequel.migration do
  up do
    create_table(:units) do
      primary_key :id
      String   :name, null: false, size: 100, unique: true
      String   :group, size: 100
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP #, :index=>true
      DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:units)
  end
end

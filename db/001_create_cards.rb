puts "--- Connected to DB"

Sequel.migration do
  up do
    create_table(:cards) do
      puts "Creating cards table"
      primary_key :id
      String :front
      String :back
      String :title
    end
  end

  down do
    puts "Dropping cards table"
    drop_table(:cards)
  end
end



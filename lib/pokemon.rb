

class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id
  

    def initialize(id:, name:, type:, db:)
        @id, @name, @type, @db = id, name, type, db
      end


    def self.save(name, type, db)
        
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0] 
    end 

    def self.new_from_db(row)
        pokemon = Pokemon.new(id: row[0],name: row[1],type: row[2],db: row[3])
        pokemon    
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL

        db.execute(sql, id).map {|row| self.new_from_db(row)}.first
    end
  
    
  
   

  end
class BDObject
  @params

  def execute(connection,statement)
    statement.execute(*@params)
    statement.finish
    connection.commit
  end

  def captions_rows_types(statement)
    statement.execute
    rows = []
    types = []
    statement.fetch{|row|
      rows << row.to_a
    }
    statement.column_types.each{|type|
      types << ((type == DBI::Type::Integer)?'int':'text')
    }
    captions = statement.column_names
    statement.finish
    return captions, rows, types
  end

end
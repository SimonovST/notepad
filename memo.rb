class Memo < Post

  def read_from_console
    puts 'Новая заметка (все. что напишите до строчки "end"):'

    @text = []
    line = nil

    until line == 'end'
      line = STDIN.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d_%H.%M.%S')} \n"

    @text.unshift(time_string)
  end

  def to_db_hash
    super.merge('text' => @text.join('\n')) #массив строк делем одной большой строкой
  end

  def load_data(data_hash)
    super(data_hash) # сперва делаем родительский методмдля инициализации полей
    # теперь прописываем свое специфическое поле
    @text = data_hash['text'].split('\n')
  end
end

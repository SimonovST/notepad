require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now
  end

  def read_from_console
    puts 'Что надо сделать?'
    @text = STDIN.gets.chomp

    puts 'К какому числу? Укажите дату в формате ДД.ММ,ГГГГ.'
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d_%H-%M-%S")} \n"

    deadline = "Крайний срок: #{@due_date}"

    [deadline, @text, time_string]
  end

  def to_db_hash
    super.merge('text' => @text, 'due_date' => @due_date.to_s)
  end

  def load_data(data_hash)
    super(data_hash) # сперва делаем родительский методмдля инициализации полей
    # теперь прописываем свое специфическое поле
    @due_date = Date.parse(data_hash['due_date'])
  end
end

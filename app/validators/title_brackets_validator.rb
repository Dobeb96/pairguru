class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    bracket_balance = 0
    previous_bracket = nil
    previous_bracket_index = -1
    opening_brackets = ['{', '(']
    closing_brackets = ['}', ')']
    record.title.split('').each_with_index do |c, i|
      if opening_brackets.include?(c)
        bracket_balance += 1
        previous_bracket = c
        previous_bracket_index = i
      elsif closing_brackets.include?(c)
        record.errors[:name] << 'Opening and closing brackets don\'t match' if previous_bracket != opening_brackets[closing_brackets.index(c)]
        record.errors[:name] << 'Empty brackets found' if previous_bracket_index == i - 1
        bracket_balance -= 1
      end
    end
    record.errors[:name] << 'Unbalanced brackets' unless bracket_balance == 0
  end
end

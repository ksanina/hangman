class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        normalized_letter = normalize_letter(letter)
        if @user_guesses.include?(normalized_letter)
          letter
        else
          nil
        end
      end
    result
  end

  def lost?
    errors_allowed == 0
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(letter)
      @user_guesses << letter
    end
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end

  def normalize_letter(any_letter)
    if any_letter == "Ё"
      any_letter = "Е"
    elsif any_letter == "Й" 
      any_letter = "И"
    else
      any_letter
    end
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end
end

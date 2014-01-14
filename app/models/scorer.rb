class Scorer

	def initialize(quiz)
		@quiz = quiz
	end

	def total(answer_ids)
		correct_num = (@quiz.correct_answer_ids & answer_ids.map(&:to_i)).length
		((correct_num/answer_ids.length.to_f) * 100).ceil
	end
end
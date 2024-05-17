class AsyncGenerateJob < ApplicationJob
  queue_as :default

  def perform(mystery_id)
    mystery = Mystery.find(mystery_id)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil))
    ActiveRecord::Base.transaction do
      generate_text = MysteryGenerate.generate_text(client, mystery.genre.name, mystery.correct_answer)
      generate_image = MysteryGenerate.generate_image(client, mystery.genre.name, mystery.correct_answer)
      mystery.update(title: generate_text[:title], content: generate_text[:content])
      mystery.image.attach(
        io: generate_image[:image],
        filename: generate_image[:filename]
      )
    rescue MysteryGenerate::OpenAiResponseError => e
      # エラーハンドリング
      Rails.logger.error "Failed to generate mystery: #{e.message}"
      mystery.destroy!
      raise ActiveRecord::Rollback
    end
  end
end

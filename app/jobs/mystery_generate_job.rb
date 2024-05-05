class MysteryGenerateJob < ApplicationJob
  queue_as :default

  def perform(mystery_id, genre, answer)
    mystery = Mystery.find(mystery_id)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil))
    response = client.images.generate(
      parameters: {
        model: 'dall-e-3',
        # prompt: "Generates a puzzle-solving image that resembles a ciphertext that abstracts the 「#{@mystery.correct_answer}」 and allows you to reach the answer by association"
        prompt: "「#{genre}」の「#{answer}」を抽象化して論理的に答えにたどり着ける問題を考えてください。ただし直接的な表現は避け、画像で生成してください"
      }
    )
    image_url = response.dig('data', 0, 'url')
    downloaded_image = URI.open(image_url)
    mystery.image.attach(io: downloaded_image, filename: "#{answer}.webp")
  end
end

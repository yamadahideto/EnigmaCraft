module OpenaiGenerate
  #   def self.generate_image(mystery)
  #     client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil))
  #     response = client.images.generate(
  #       parameters: {
  #         model: 'dall-e-3',
  #         prompt: mystery.correct_answer.to_s
  #       }
  #     )
  #     image_url = response.dig('data', 0, 'url')
  #     downloaded_image = URI.open(image_url)
  #     mystery.image.attach(io: downloaded_image, filename: "#{mystery.correct_answer}.webp")
  #   end
end

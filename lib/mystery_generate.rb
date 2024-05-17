module MysteryGenerate
  # 例外クラスを作成
  class OpenAiResponseError < StandardError; end

  # 文章生成メソッド
  def self.generate_text(client, genre, correct_answer)
    begin
      response = client.chat(
        parameters: {
          model: 'gpt-4',
          messages: [
            { role: 'system', content: 'あなたは暗号文のような謎解きを考えるプロです' },
            { role: 'user', content: "「#{genre}」の「#{correct_answer}」を抽象化して論理的に答えに辿りつける問題を考えてください。ただし直接的な表現は避け、タイトルと200字程度の問題文をのみを生成してください。タイトルは「」で囲み、最後に/を入れてください 問題は*の後に続けてください" }
          ],
          temperature: 0.7
        }
      )
      # 生成されるレスポンスからタイトルを抽出
      title = response.dig('choices', 0, 'message', 'content').match(%r{^(.*?)(?=/)})
      # 生成されるレスポンスから問題文を抽出
      content = response.dig('choices', 0, 'message', 'content').match(/\*(.*)/)

    { title: title, content: content }
    rescue Faraday::Error => e
       raise handle_error(e)
    end
  end

  # 画像生成メソッド
  def self.generate_image(client, genre, answer)
    begin
      response = client.images.generate(
        parameters: {
          model: 'dall-e-3',
          prompt: "「#{genre}」の「#{answer}」を抽象化して論理的に答えにたどり着ける問題を考えてください。ただし直接的な表現は避け、画像で生成してください"
        }
      )
      image_url = response.dig('data', 0, 'url')
      image = URI.open(image_url)
      filename = "#{answer}.webp"
      { image: image, filename: filename }
    rescue Faraday::Error => e
      raise handle_error(e)
    end
  end

  def self.handle_error(e)
    status = e.response[:status]
    case status
    when 401
      raise OpenAiResponseError, "認証に失敗しました。管理者にお問い合わせください"
    when 429
      raise OpenAiResponseError, "リクエストの制限を超えました。しばらく経ってから再度お試しください"
    when 500
      raise OpenAiResponseError, "内部エラーが発生しました。管理者にお問い合わせください"
    when 503
      raise OpenAiResponseError, "現在利用ができません。しばらく経ってから再度お試しください"
    else
      raise OpenAiResponseError, "予期せぬエラーが発生しました。管理者にお問い合わせください"
    end
  end

end
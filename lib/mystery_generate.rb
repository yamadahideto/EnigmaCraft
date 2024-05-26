module MysteryGenerate
  # 例外クラスを作成
  class OpenAiResponseError < StandardError; end

  def self.create_mystery_content(genre, correct_answer)
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil)) 
    begin
      text = generate_text(client, genre, correct_answer)
      image = generate_image(client, genre, correct_answer)
      
      if text[:title].blank? || text[:content].blank? || image[:image].blank? || image[:filename].blank?
        raise OpenAiResponseError, "予期せぬレスポンス形式です。"
      else
        { title: text[:title], content: text[:content], image: image[:image], filename: image[:filename] }
      end

    rescue Faraday::Error => e
      raise handle_error(e)
    end
  end

  # 文章生成メソッド
  def self.generate_text(client, genre, correct_answer)
    begin
      response = client.chat(
        parameters: {
          model: 'gpt-4',
          messages: [
            { role: 'system', content: 'あなたは暗号文のような謎解きを考えるプロです' },
            { role: 'user', content: "「#{genre}」の「#{correct_answer}」を抽象化して論理的に答えに辿りつける問題を考えてください。ただし直接的な表現は避け、タイトルと100文字までの問題文をのみを生成してください。タイトルは「」で囲み、問題分は<>囲ってください" }
          ],
          temperature: 0.7
        }
      )
      # レスポンスが返ってきているかチェック
      if response.key?('choices') && response['choices'].any?
        response.dig('choices', 0, 'message', 'content')
        # レスポンスからタイトルを抽出
        title = response.dig('choices', 0, 'message', 'content').match(/「(.*?)」/)
        # レスポンスから問題文を抽出
        match = response.dig('choices', 0, 'message', 'content').match(/<([^>]*)>/)
        content = match[1] if match
        { title: title, content: content }

      else
        raise OpenAiResponseError, "予期せぬレスポンス形式です。"
      end

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

  # OpenAIエラーハンドリングを追加
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
require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "test", email: "test@example.com", password: "password")
  end

  test "get new article form and create new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: {title: "A new article", description: "The description of the article", category_ids: []} }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match "A new article", response.body
  end
end

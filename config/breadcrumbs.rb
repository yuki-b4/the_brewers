crumb :articles do
  link "トップページ", root_path
end

crumb :article do |article|
  link article.title, article_path(article)
  parent :articles
end

crumb :edit_article do |article|
  link "#{article.title}の編集", edit_article_path
  parent :article, article
end

crumb :user do |user|
  link "ユーザー詳細", user_path(user)
  parent :articles
end

crumb :user_edit do |user|
  link "ユーザー編集", edit_user_path(user)
  parent :user, user
end




# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
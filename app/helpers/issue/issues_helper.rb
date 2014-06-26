module Issue::IssuesHelper
  def get_issue_status_icon(issue)
    icon = case issue.status
             when 'open'
               'eye-open'
             when 'close'
               'eye-close'
             else
           end
    content_tag :span, '', class: "glyphicon glyphicon-#{icon} issue-icon #{issue.status}"
  end
end

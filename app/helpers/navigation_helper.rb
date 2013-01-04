module NavigationHelper
  def weekly_navigation(date)
    content_tag :h2, id: 'week' do
      link_to('<', date: date.prev_week) +
      date.strftime(' Week %V - %Y ') +
      link_to('>', date: date.next_week)
    end
  end

  def monthly_navigation(date)
    content_tag :h2, id: 'month' do
      link_to('<', date: date.prev_month) +
      date.strftime(' Month %b - %Y ') +
      link_to('>', date: date.next_month)
    end
  end

  def search(path, date)
    form_tag path, method: 'get', id: 'search_form' do
      content_tag :p do
        text_field_tag(:date, date) +
        submit_tag('Go', name: nil)
      end
    end
  end
end
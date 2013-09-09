class CardProcessingsDatatable
  delegate :params, :h, :link_to, :number_to_currency, :print_datetime, :print_date, :edit_student_exam_path, :can?, :destroy_link, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: CardProcessing.count,
      aaData: data,
      iTotalDisplayRecords: @iTotalDisplayRecords
    }
  end

private
  def data
    card_processings.map do |card_processing|
      [
        h(card_processing.name),
        h(print_datetime(card_processing.created_at)),
        card_processing.status + '<span><br/>' + links(card_processing) + '</span>',
        h(card_processing.student_exams.select{|se| se.needs_check?}.size.to_s + ' / ' + card_processing.student_exams.size.to_s),
        h(print_date(card_processing.exam_date)),
        h(card_processing.campus.name)
      ]
    end
  end

  def links(card_processing)
    links = []
    if card_processing.processed?
      links << link_to('Show', card_processing)
      if card_processing.needs_check?
        links << link_to('Check', edit_student_exam_path(card_processing.to_be_checked))
      end
    end
    if can?(:destroy, card_processing)
      links << destroy_link(card_processing)
    end
    return links.join(' | ')
  end

  def card_processings
    @card_processings ||= fetch_products
    return @card_processings
  end

  def fetch_products
    card_processings = CardProcessing.order("#{sort_column} #{sort_direction}").includes(:campus, :student_exams)
    if params[:sSearch].present?
      card_processings = card_processings.where("name like :search or to_char(created_at, 'YYYY-MM-DD HH12-MI-SS') like :search or status like :search or (select name from card_types where id = card_type_id) like :search or to_char(exam_date, 'YYYY-MM-DD') like :search or (select name from campuses where id = campus_id) like :search", search: "%#{params[:sSearch]}%")
    end
    @iTotalDisplayRecords = card_processings.size
    card_processings = card_processings.page(page).per(per_page)
    card_processings
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = ['name', 'created_at', 'status', 
      "(select count(id) + 1000 * (count(id) - coalesce(sum(case when status in ('Valid', 'Being processed') then 1 else 0 end), 0)) from student_exams where card_processing_id = card_processings.id)",
      'exam_date', 
      '(select name from campuses where id = campus_id)']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
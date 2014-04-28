#encoding: utf-8

class CardProcessingsDatatable
  delegate :params, :h, :link_to, :number_to_currency, :print_datetime, :print_date, :edit_student_exam_path, :edit_card_processing_path, :can?, :destroy_link, to: :@view

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
        CardProcessing.translate_status(card_processing.status) + '<span><br/>' + links(card_processing) + '</span>',
        h(card_processing.student_exams.select{|se| se.needs_check?}.size.to_s + ' / ' + card_processing.student_exams.size.to_s),
        h(print_date(card_processing.exam_date)),
        h(card_processing.campus.name)
      ]
    end
  end

  def links(card_processing)
    links = []
    if card_processing.processed?
      links << link_to('Cartões', card_processing)
      if card_processing.needs_check?
        links << link_to('Checar', edit_student_exam_path(card_processing.to_be_checked))
      end
    end
    if can?(:destroy, card_processing)
      links << destroy_link(card_processing)
      links << link_to('Reprocessar', edit_card_processing_path(card_processing))
    end
    return links.join(' | ')
  end

  def card_processings
    @card_processings ||= fetch_products
    return @card_processings
  end

  def fetch_products
    card_processings = CardProcessing.where(campus_id: Campus.accessible_by(@view.current_ability).map(&:id)).order("#{sort_column} #{sort_direction}").includes(:campus, :student_exams)
    if params[:sSearch].present?
      card_processings = card_processings.where(
        "name || ' ' || 
        to_char(created_at, 'DD/MM/YYYY HH12-MI-SS') || ' ' || 
        status || ' ' || 
        (select name from card_types where id = card_type_id) || ' ' || 
        to_char(exam_date, 'DD/MM/YYYY') || ' ' || 
        (select name from campuses where id = campus_id) ilike :search", 
      search: "%#{params[:sSearch].gsub(/ /, '%')}%")
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
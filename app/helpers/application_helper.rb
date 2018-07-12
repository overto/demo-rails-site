module ApplicationHelper

  def calendar (month, year)

    passed_date = Date.new(year, month)
    today = Time.now

    if passed_date.month == 1
      prev_year = passed_date.prev_year.year
    else
      prev_year = passed_date.year
    end

    if passed_date.month == 12
      next_year = passed_date.next_year.year
    else
      next_year = passed_date.year
    end

    prev_month = passed_date.prev_month.month
    next_month = passed_date.next_month.month

    first_day = passed_date.at_beginning_of_month.wday
    days_in_month = passed_date.at_end_of_month.day
    day_counter = 0

    rows = (days_in_month + first_day) / 7
    if (days_in_month + first_day) % 7 > 0
      rows += 1
    end

    start_counting = false

    calendar_html = '<table class="table table-responsive cal-table">'
    calendar_html += '<tr><th colspan="1">' + link_to(image_tag("left-arrow.png", alt: "left arrow"), calendar_path(month: prev_month, year: prev_year)) + '</th>'
    calendar_html += '<th colspan="5" class="cal-table-date-header">' + passed_date.strftime("%B %Y") + '</th>'
    calendar_html += '<th colspan="1">' + link_to(image_tag("right-arrow.png", alt: "right arrow"), calendar_path(month: next_month, year: next_year)) + '</th></tr>'
    calendar_html += '<tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr>'

    rows.times do |week|
      calendar_html += '<tr>'
      7.times do |day|

        if first_day == day && week == 0
          start_counting = true
        end

        if start_counting == true && day_counter < days_in_month
            day_counter += 1
            if passed_date.year == today.year && passed_date.month == today.month && day_counter == today.day
              calendar_html += '<td class="today-td">'
            else
              calendar_html += '<td>'
            end
            calendar_html += '<p>' + day_counter.to_s + '</p>'
        else
          calendar_html += '<td>'
        end

        calendar_html += '</td>'
      end
      calendar_html += '</tr>'
    end
    calendar_html += '</table>'

    return calendar_html.html_safe
  end

end

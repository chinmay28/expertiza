class Mailer < ActionMailer::Base
  if Rails.env.development? || Rails.env.test?
    default from: 'expertiza.development@gmail.com'
  else
    default from: 'expertiza-support@lists.ncsu.edu'
  end

  def generic_message(defn)
    @partial_name = defn[:body][:partial_name]
    @user = defn[:body][:user]
    @first_name = defn[:body][:first_name]
    @password = defn[:body][:password]
    @new_pct = defn[:body][:new_pct]
    @avg_pct = defn[:body][:avg_pct]
    @assignment = defn[:body][:assignment]

    if Rails.env.development? || Rails.env.test?
      defn[:to] = 'expertiza.development@gmail.com'
    end
    mail(subject: defn[:subject],
         to: defn[:to],
         bcc: defn[:bcc])
  end

  def request_user_message(defn)
    @user = defn[:body][:user]
    @super_user = defn[:body][:super_user]
    @first_name = defn[:body][:first_name]
    @new_pct = defn[:body][:new_pct]
    @avg_pct = defn[:body][:avg_pct]
    @assignment = defn[:body][:assignment]

    if @assignment.instructor.copy_of_all_emails
      defn[:bcc] << @assignment.instructor.email
    end

    if Rails.env.development? || Rails.env.test?
      defn[:to] = 'expertiza.development@gmail.com'
    end
    mail(subject: defn[:subject],
         to: defn[:to],
         bcc: defn[:bcc])
  end

  def sync_message(defn)
    @body = defn[:body]
    @type = defn[:body][:type]
    @obj_name = defn[:body][:obj_name]
    @first_name = defn[:body][:first_name]
    @partial_name = defn[:body][:partial_name]
    @team_id = defn[:body][:team_id]

    if Rails.env.development? || Rails.env.test?
      defn[:to] = 'expertiza.development@gmail.com'
    end
    mail(subject: defn[:subject],
         # content_type: "text/html",
         to: defn[:to])
  end

  def delayed_message(defn)
    ret = mail(subject: defn[:subject],
               body: defn[:body],
               content_type: "text/html",
               bcc: defn[:bcc])
    CUSTOM_LOGGER.info(ret.encoded.to_s)
  end

  def suggested_topic_approved_message(defn)
    @body = defn[:body]
    @topic_name = defn[:body][:approved_topic_name]
    @proposer = defn[:body][:proposer]

    if Rails.env.development? || Rails.env.test?
      defn[:to] = 'expertiza.development@gmail.com'
    end
    mail(subject: defn[:subject],
         to: defn[:to],
         bcc: defn[:cc])
  end

  # emails about a suggested topics to the instructor
  def new_topic_suggested_message(defn)
    @proposer = defn[:body][:proposer]
    @topic_name = defn[:body][:topic_name]
    @body = defn[:body]

    if Rails.env.development? || Rails.env.test?
      defn[:to] = 'expertiza.development@gmail.com'
    end
    mail(subject: defn[:subject],
         to: defn[:to],
         bcc: defn[:cc])
  end

  def notify_grade_conflict_message(defn)
    @body = defn[:body]

    @assignment = @body[:assignment]
    @reviewer_name = @body[:reviewer_name]
    @type = @body[:type]
    @reviewee_name = @body[:reviewee_name]
    @new_score = @body[:new_score]
    @avg_score = @body[:avg_score]
    @conflicting_response_url = @body[:conflicting_response_url]
    @summary_url = @body[:summary_url]
    @assignment_edit_url = @body[:assignment_edit_url]

    if Rails.env.development? || Rails.env.test?
      defn[:to] = 'expertiza.development@gmail.com'
    end
    mail(subject: defn[:subject],
         to: defn[:to])
  end

  # invite message related emails
  def invite_message(defn)
    @partial_name = defn[:body][:partial_name]
    @sender = defn[:body][:sender]
    @receiver = defn[:body][:receiver]
    if Rails.env.development? || Rails.env.test?
      defn[:to] = 'expertiza.development@gmail.com'
    end
    mail(subject: defn[:subject],
         to: defn[:to],
         bcc: defn[:bcc])
  end
end

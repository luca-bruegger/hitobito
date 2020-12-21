# frozen_string_literal: true

#  Copyright (c) 2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.

class MessagesController < CrudController

  skip_authorize_resource
  before_action :authorize_action

  include YearBasedPaging

  self.nesting = Group, MailingList

  private

  def list_entries
    parent.messages.list.in_year(year)
  end

  def parent
    recipients_source
  end

  def recipients_source
    MailingList.find(mailing_list_id)
  end

  def mailing_list_id
    params[:mailing_list_id]
  end

  def authorize_class
    authorize_action
  end

  def authorize_action
    authorize!(:update, recipients_source)
  end

end

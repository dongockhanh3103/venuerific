# frozen_string_literal: true

class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Authz::UnauthorizedError, with: :render_403

  private

  def render_404(exception = nil)
    logger.info "Rendering 404: #{exception.message}" if exception

    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  def render_403(exception = nil)
    logger.info "Rendering 403: #{exception.message}" if exception

    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

end

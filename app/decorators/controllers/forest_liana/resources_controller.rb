ForestLiana::ResourcesController.class_eval do
  unless Rails.env.development?
    caches_action :index, cache_path: Proc.new { |c| c.request.url }
  end

  def create
    render body: 'You can only read data on this public demo application.',
      status: 403
  end

  def update
    render body: 'You can only read data on this public demo application.',
      status: 403
  end

  def destroy
    render body: 'You can only read data on this public demo application.',
      status: 403
  end
end

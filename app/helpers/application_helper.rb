module ApplicationHelper
  def default_meta_tags
    title = content_for?(:title) ? yield(:title) : 'Quester'
    description = content_for?(:description) ? yield(:description) : '匿名で質問を募り、回答を集めるためのサービスです。'
    current_url = request.original_url
    share_image = image_url('default.png')
    favicon_path = image_url('favicon.png')
    favicon_shortcut = ActionController::Base.helpers.asset_path('favicon.png')

    {
      site: 'Quester',
      title: 'Quester',
      description: description,
      charset: 'utf-8',
      canonical: current_url,
      icon: [
        { href: favicon_path, rel: 'icon', type: 'image/png' },
        { href: favicon_shortcut, rel: 'shortcut icon', type: 'image/png' },
      ],
      og: {
        type: 'website',
        title: title,
        description: description,
        url: current_url,
        image: share_image,
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        title: title,
        description: description,
        image: share_image,
      },
    }
  end
end

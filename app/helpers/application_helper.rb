module ApplicationHelper
  def default_meta_tags
    title = content_for?(:title) ? yield(:title) : 'Quester - 匿名で質問を集めよう'
    description = content_for?(:description) ? yield(:description) : '匿名で質問を募り、回答を集めるためのサービスです。'
    current_url = request.original_url
    share_image = image_url('default.png')
    favicon_path = image_url('favicon.png')

    {
      site: 'Quester',
      title: title,
      description: description,
      charset: 'utf-8',
      canonical: current_url,
      icon: [
        { href: favicon_path },
        { href: image_url('favicon.ico'), rel: 'shortcut icon', type: 'image/x-icon' },
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

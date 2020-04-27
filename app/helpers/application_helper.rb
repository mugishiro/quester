module ApplicationHelper
  def default_meta_tags
    {
      site: 'Quester',
      charset: 'utf-8',
      canonical: request.original_url,
      icon: image_url('favicon.png'),
      og: {
        type: 'website',
        url: request.original_url,
        image: image_url('default.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
      },
    }
  end
end

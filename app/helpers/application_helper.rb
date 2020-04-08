module ApplicationHelper
  def default_meta_tags
   {
     site: 'hoge',
     title: 'hoge',
     reverse: true,
     charset: 'utf-8',
     description: 'situmon',
     keywords: 'hoge',
     canonical: request.original_url,
     separator: '|',
     icon: [
       { href: image_url('favicon.ico') },
       { href: image_url('box.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
     ],
     og: {
       site_name: 'hoge', # もしくは site_name: :site
       title: 'hoge', # もしくは title: :title
       description: 'hoge', # もしくは description: :description
       type: 'website',
       url: request.original_url,
       image: 'https://tk.ismcdn.jp/mwimgs/e/b/1140/img_eb31afc9c1fb914d68a7c73b657c7ebe183087.jpg',
       # image: image_url('/assets/box.jpg'),
       locale: 'ja_JP',
     },
     twitter: {
       card: 'summary_large_image',
     }
   }
   # 変更するべきあたいはtitle, description, og:title, og;description, og:image,
  end
end

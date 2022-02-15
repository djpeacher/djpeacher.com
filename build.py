from staticjinja import Site


if __name__ == "__main__":
    site = Site.make_site(
        outpath="build",
        extensions=['jinja2.ext.with_'],
        staticpaths=['images/', 'files/'],
        env_globals={
            'countapi': True,
        })
    site.render()

import requests
from collections import Counter
from tabulate import tabulate


def check_url(link, params):
    check_git_link = requests.get(link, params)
    if check_git_link.status_code != 200:
        print("User or repository not found")
        print(link)
        quit()
    return check_git_link


def most_productive_authors(user, repo):
    page_list = int(input('Enter number of the last Pull Request. (multiple of 100) : '))
    page_list = int(page_list/100)
    uniq_authors = {}
    for i in range(0, page_list):
        params = {'per_page': 100, 'page': i, 'state': 'all'}
        check_link = check_url(f"https://api.github.com/repos/{user}/{repo}/pulls", params)
        for link in check_link.json():
            author = link['user']['login']
            author_pr_number = link['number']
            uniq_authors[author_pr_number] = author
    uniq_authors = Counter(uniq_authors.values())
    uniq_authors = uniq_authors.most_common()
    uniq_authors = ((k, v) for k, v in uniq_authors if v > 1)
    print(tabulate(uniq_authors, headers=['Authors', 'Count of PR'], tablefmt='fancy_grid'))


git_user = input('GitHub user name: ')
git_repo = input('GitHub user repository: ')
most_productive_authors(git_user, git_repo)

import requests


def check_url(user, repo):
    check_git_link = requests.get(f"https://api.github.com/repos/{user}/{repo}/commits")
    if check_git_link.status_code == 200:
        print("User or repository found")
    else:
        print("User or repository not found")


git_user = input('GitHub user name: ')
git_repo = input('GitHub user repository: ')
check_url(git_user, git_repo)

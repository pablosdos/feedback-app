# CREATE MOCK DATA

# uncomment created_at line in Feedback Model and makemigrations/migrate it first
# ✗ pipenv run python manage.py shell
# paste following script and execute by pressing Enter

from feedback.models import Feedback
import random
from datetime import date, timedelta


def daterange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)


start_date = date(2024, 5, 1)
end_date = date(2024, 6, 28)
myNumbers = [0, 1, 2, 3, 4, 5]
for single_date in daterange(start_date, end_date):
    Feedback.objects.create(
        User_id="volkers@gmail.de",
        motivation=random.choice(myNumbers),
        muskulaere_erschoepfung=random.choice(myNumbers),
        koerperliche_einschraenkung=random.choice(myNumbers),
        schlaf=random.choice(myNumbers),
        stress=random.choice(myNumbers),
        created_at=single_date,
    )

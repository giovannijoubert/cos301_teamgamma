from django.shortcuts import render
from django.http import HttpResponse, HttpResponseForbidden, HttpResponseNotFound, JsonResponse
import hashlib


def robots_txt(request):
    # Block search engine indexing
    return HttpResponse("User-Agent: *\nDisallow: /", content_type="text/plain")

# GAMMA API
def echo_api(request, user_txt):
    # docs: https://docs.djangoproject.com/en/3.0/ref/request-response/
    # Demo API to output URL string
    return JsonResponse({'user_input': user_txt, 'request': request.method, 'server': request.META.get("SERVER_NAME"), 'ip': request.META.get("REMOTE_ADDR")})

def training_api(request):
    # TODO: Send data to neural network
    if request.method == 'POST' and request.META.get("SERVER_NAME") == "ai.teamgamma.ga":
        if request.POST.get("checksum", None) != None and request.POST.get("sounddata", None) != None:
            data_test = hashlib.md5(request.POST.get("sounddata", None).encode())
            if data_test == request.POST.get("checksum", None):
                # Send data to neural network
                return JsonResponse({'result': 'Ok'})
            else:
                return JsonResponse({'result': 'Invalid Checksum'})
        else:
            return JsonResponse({'result': 'Invalid Request'})
    else:
        return JsonResponse({'result': 'Bad Request'})